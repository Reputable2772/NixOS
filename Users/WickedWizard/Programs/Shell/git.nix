{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    libsecret
    lazygit
  ];

  programs.git = {
    enable = true;
    userEmail = "153411261+Reputable2772@users.noreply.github.com";
    userName = "Reputable2722";
    extraConfig = {
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "/home/wickedwizard/.config/git/allowed_signers";
      };
    };
    signing = {
      key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC05WkGXPooEYhfb2R6cTq/GBEq739jmyfcuMqXUG6Xpz5/TIvCvpjDU2vm7XyOCnThklXrPwcixavl4DunTxIs8kSTLp7u2TkMzxM3e7JxNlBUJGy4OMEMFeocsrbMjh9utd+K+PBgGvM/rsEkLMYGbOGRsS+476stZwCa6Sa8aE5TENuW6Bp0SNf4HwdHdIo+/U9yUtEgnM8SP7kCGCUYIcFoXB5jPdHujG23snvF68bwg5i7WBp/PmhpHhV1aMDkSrzRw2wx/zOISIHU23bX8L5rOiTTqWU6yZQ5T9YutKcOOF6eA1vtccJ6JuiahusbMYYTYNyh0IqY6wszO7P4Fl/KZ3/0E6x5atzv+m8DslEsOBiEBu2Nuv0359OiEOH5u6psbjw1KYEtpAf3UwqIT5Cc9mDiOyHTrQQgEddv+IM1vz44Mhc5In66I509APIzjGNGzJ9s9RoRzmhOvjezWak69+rUIr/SuUHzhrvsa9cpG5ASP431tvKmEuD4BXREw32Z5oMt789C/jtknoROu3sWVSeMxKPj8m5Wvq1KyoCJ0biJhHizGV2tvssPJbhBduOWlstK4FlUScFTWlW4doBA3yKOOa25KmRsfiQkQ8pjid5shIJ6CDzsSjIdkT8tSegr2/RzlL9EVC1xii/zAXOqV/+x4SOYD8MdvqXVKw== wickedwizard@hp-laptop";
      signByDefault = true;
    };
  };
}
