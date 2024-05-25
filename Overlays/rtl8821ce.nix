final: prev: {
  linuxKernel = prev.linuxKernel // {
    packages = prev.linuxKernel.packages // {
      linux_zen = prev.linuxKernel.packages.linux_zen // {
        rtl8821ce = prev.linuxKernel.packages.linux_zen.rtl8821ce.overrideAttrs {
          src = prev.fetchFromGitHub {
            owner = "tomaspinho";
            repo = "rtl8821ce";
            rev = "f119398d868b1a3395f40c1df2e08b57b2c882cd";
            hash = "sha256-EfpKa5ZRBVM5T8EVim3cVX1PP1UM9CyG6tN5Br8zYww=";
          };
        };
      };
    };
  };
}
