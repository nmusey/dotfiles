{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.modules.services.vm;
  usbPassthrough = pkgs.writeShellApplication {
    name = "vm-usb-passthrough";
    runtimeInputs = with pkgs; [
      libvirt
      coreutils
    ];
    text = ''
      domain="''${1:?usage: vm-usb-passthrough <domain> [vendor-id...]}"
      shift
      vendors=("$@")
      [ ''${#vendors[@]} -eq 0 ] && vendors=(${lib.concatStringsSep " " cfg.usbVendors})

      for dev in /sys/bus/usb/devices/*; do
        [ -f "$dev/idVendor" ] || continue
        vendor=$(cat "$dev/idVendor")
        product=$(cat "$dev/idProduct")
        for want in "''${vendors[@]}"; do
          [ "$vendor" = "$want" ] || continue
          echo "attaching $vendor:$product $(cat "$dev/product" 2>/dev/null || true)"
          xml=$(mktemp)
          cat > "$xml" <<EOF
      <hostdev mode='subsystem' type='usb' managed='yes'>
        <source startupPolicy='optional'>
          <vendor id='0x$vendor'/>
          <product id='0x$product'/>
        </source>
      </hostdev>
      EOF
          virsh --connect qemu:///system attach-device "$domain" "$xml" --config || true
          rm -f "$xml"
        done
      done
    '';
  };
in
{
  config = lib.mkIf cfg.enable {
    users.users.${config.variables.global.username}.extraGroups = [
      "libvirtd"
      "kvm"
    ];

    boot.kernelParams = [
      "amd_iommu=on"
      "iommu=pt"
    ];
    boot.kernelModules = [
      "vfio"
      "vfio_pci"
      "vfio_iommu_type1"
    ];

    virtualisation.libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
    virtualisation.spiceUSBRedirection.enable = true;
    programs.virt-manager.enable = true;

    environment.systemPackages = with pkgs; [
      virt-viewer
      spice-gtk
      usbutils
      usbPassthrough
    ];

    environment.etc."virtio-win/virtio-win.iso".source = "${pkgs.virtio-win.src}";
  };
}
