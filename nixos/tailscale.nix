{
  isMac,
  ...
}:
{
  services.tailscale.enable = true;
}
// (
  if isMac then
    {
    }
  else
    {
      boot.kernel.sysctl = {
        "net.ipv4.ip_forward" = 1;
        "net.ipv6.conf.all.forwarding" = 1;
      };
    }
)
