{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      inherit (self) outputs;

      systems = [
        "x86_64-linux"
      ];

      pkgsFor = nixpkgs.lib.genAttrs systems (
        system:
        import nixpkgs {
          inherit system;
        }
      );
    in
    {
      devShells.x86_64-linux.default =
        let
          pkgs = pkgsFor.x86_64-linux;
        in
        pkgs.mkShell {
          buildInputs = [
            pkgs.nil
            pkgs.nixfmt-rfc-style
            pkgs.nodejs_23
            pkgs.yaml-language-server
            pkgs.nodePackages.prettier
          ];
        };

      formatter.x86_64-linux =
        let
          pkgs = pkgsFor.x86_64-linux;
        in
        pkgs.nixfmt-rfc-style;
    };
}
