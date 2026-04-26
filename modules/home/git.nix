{ ... }: {
  programs.git = {
    enable = true;
    settings = {
      user.name = "pocketpoke";
      user.email = "191191762+pocketpoke@users.noreply.github.com";
      credential.helper = "store";
    };
  };
}
