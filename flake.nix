{
  description = "My personal flake template collection";

  outputs = {self
  , ... }@inputs: {
    templates = {
      basic = {
        path = ./templates/basic;
        description = "Template of a basic development environment";
      };
      c-basic = {
        path = ./templates/c-basic;
        description = "Template of a basic C development environment";
      };
    };
  };
}
