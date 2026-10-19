{}:
{	
    documentation.enable = true;
	documentation.man.enable = true;
	documentation.man.generateCaches = true;

	environment.systemPackages = with pkgs; [ 
		tealdeer
		dasht 
	];
}
