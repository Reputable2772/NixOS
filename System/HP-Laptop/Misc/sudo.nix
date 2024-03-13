{
  security.sudo = {
    execWheelOnly = true;
    configFile = ''
      Defaults passwd_timeout=0
      Defaults timestamp_type=global
      Defaults timestamp_timeout=10
      Defaults insults
      Defaults pwfeedback
    '';
  };
}
