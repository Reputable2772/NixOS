{ lib, ... }:
{
  users.users.root = {
    hashedPassword = "$y$j9T$9/KGaTN/CZYqZW8yKRDoE1$dkFKoTui8jaNPYuU4B6uGLEKvJfBnbM6mgn/iJTQK49";
    initialHashedPassword = lib.mkForce null;
  };

  users.users.nixos = {
    isNormalUser = true;
    home = "/home/nixos";
    description = "A NixOS user, with rescue features!";
    extraGroups = [
      "wheel"
      "networkmanager"
      "input"
      "video"
      "render"
    ];
    hashedPassword = "$y$j9T$6ebxbfKLaxJRhW/0WyvIo0$18Sa.jcxz1MKYTJo6v4Y35A1TVaMYrFpBiektPZ4AJ6";
    initialHashedPassword = lib.mkForce null;
  };
}
