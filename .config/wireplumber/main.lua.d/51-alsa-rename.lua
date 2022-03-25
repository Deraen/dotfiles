-- Disable non-existing input on DAC
rule = {
  matches = {
    {
      { "node.name", "equals", "alsa_input.usb-Audinst__Inc._Audinst_HUD-mx1-01.analog-stereo" },
      { "media.class", "equals", "Audio/Source" }
    }
  },
  apply_properties = {
    ["node.disabled"] = true,
  },
}

table.insert(alsa_monitor.rules,rule)

-- Set nick for webcam
rule = {
  matches = {
    {
      { "device.name", "equals", "alsa_card.usb-046d_0825_68E56DA0-02" },
    },
  },
  apply_properties = {
    ["device.nick"] = "Logitech Webcam",
  },
}

table.insert(alsa_monitor.rules,rule)

-- Disable Nvidia HDMI ports
rule = {
  matches = {
    {
      { "device.name", "equals", "alsa_card.pci-0000_06_00.1" },
    },
  },
  apply_properties = {
    ["device.disabled"] = true,
  },
}

table.insert(alsa_monitor.rules,rule)
