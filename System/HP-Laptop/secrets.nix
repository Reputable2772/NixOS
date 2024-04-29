let
  # This should be a passwordless ssh key
  encryption = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN618WSaf14crbHvqgDdhAqkgjz6tmyjKwL00viq5CQd wickedwizard@hp-laptop";
in
{
  "../../Config/Cachix.age".publicKeys = [ encryption ];
}
