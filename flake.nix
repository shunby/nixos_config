{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        xremap.url = "github:xremap/nix-flake";
    };

    outputs = inputs: {
        nixosConfigurations = {
            myNixOS = inputs.nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./configuration.nix
                ];

                specialArgs = {
                    inherit inputs;
                };
                
            };
        };
    };
}