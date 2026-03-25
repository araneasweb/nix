_: prev: {
  weechat = prev.weechat.override {
    configure =
      { availablePlugins, ... }:
      {
        scripts = with prev.weechatScripts; [
          weechat-otr
          wee-slack
          weechat-go
          weechat-grep
          weechat-autosort
        ];
      };
  };
}
