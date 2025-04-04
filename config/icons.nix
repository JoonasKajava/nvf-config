{lib, ...}: let
  inherit (lib.nvim.dag) entryBefore;
  inherit (lib.nvim.lua) toLuaObject;

  icons = {
    misc = {
      dots = "󰇘";
    };
    ft = {
      octo = "";
    };
    dap = {
      Stopped = ["󰁕 " "DiagnosticWarn" "DapStoppedLine"];
      Breakpoint = " ";
      BreakpointCondition = " ";
      BreakpointRejected = [" " "DiagnosticError"];
      LogPoint = ".>";
    };
    diagnostics = {
      Error = " ";
      Warn = " ";
      Hint = " ";
      Info = " ";
    };
    git = {
      added = " ";
      modified = " ";
      removed = " ";
    };
    kinds = {
      Array = " ";
      Boolean = "󰨙 ";
      Class = " ";
      Codeium = "󰘦 ";
      Color = " ";
      Control = " ";
      Collapsed = " ";
      Constant = "󰏿 ";
      Constructor = " ";
      Copilot = " ";
      Enum = " ";
      EnumMember = " ";
      Event = " ";
      Field = " ";
      File = " ";
      Folder = " ";
      Function = "󰊕 ";
      Interface = " ";
      Key = " ";
      Keyword = " ";
      Method = "󰊕 ";
      Module = " ";
      Namespace = "󰦮 ";
      Null = " ";
      Number = "󰎠 ";
      Object = " ";
      Operator = " ";
      Package = " ";
      Property = " ";
      Reference = " ";
      Snippet = "󱄽 ";
      String = " ";
      Struct = "󰆼 ";
      Supermaven = " ";
      TabNine = "󰏚 ";
      Text = " ";
      TypeParameter = " ";
      Unit = " ";
      Value = " ";
      Variable = "󰀫 ";
    };
  };
in {
  vim.luaConfigRC.icons =
    entryBefore ["globalsScript"]
    ''
      nvf_icons = ${toLuaObject icons}
    '';
}
