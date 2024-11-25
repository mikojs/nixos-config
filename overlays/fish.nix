final: prev: {
  fish = prev.fish.overrideAttrs (previousAttrs: {
    postInstall = (previousAttrs.postInstall or "") + ''
      tide configure --auto --style=Classic --prompt_colors='True color' --classic_prompt_color=Dark --show_time=No --classic_prompt_separators=Angled --powerline_prompt_heads=Sharp --powerline_prompt_tails=Flat --powerline_prompt_style='Two lines, character' --prompt_connection=Disconnected --powerline_right_prompt_frame=No --prompt_spacing=Compact --icons='Many icons' --transient=No
    '';
  });
}
