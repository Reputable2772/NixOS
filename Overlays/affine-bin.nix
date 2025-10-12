final: prev: {
  affine-bin = prev.affine-bin.overrideAttrs (finalAttrs: {
    src = prev.fetchurl {
      url = "https://github.com/toeverything/AFFiNE/releases/download/v0.24.1/affine-0.24.1-stable-linux-x64.zip";
      hash = "sha256-t7FnYoF4HuWrxSQ59FwIHfk/wtM95yebCVz6b1t3s2U=";
    };
  });
}
