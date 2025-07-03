{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    cargo
    rustc
    clippy
    rustfmt
  ];
}
