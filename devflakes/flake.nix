{
  outputs = _: {
    templates = {
      typescript = {
        path = ./typescript;
      };
      default = {
        path = ./default;
      };
      apl = {
        path = ./apl;
      };
    };
  };
}
