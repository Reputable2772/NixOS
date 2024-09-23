final: prev: {
  auto-cpufreq = prev.auto-cpufreq.overrideAttrs (old: {
    propagatedBuildInputs = (old.propagatedBuildInputs) ++ [ prev.getent ];
  });
}
