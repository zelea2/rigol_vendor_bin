#include <stddef.h>

char         *scope_models[] = {
  "DHO802", "DHO804", "DHO812", "DHO814", "DHO914", "DHO914S", "DHO924",
  "DHO924S", "DS70104", "DS70204", "DS70304", "DS70404", "DS70504", "DS70604",
  "DHO1052", "DHO1054", "DHO1072", "DHO1074", "DHO1102", "DHO1104", "DHO1202",
  "DHO1204", "DHO2104", "DHO2204", "DHO4104", "DHO4204", "DHO4304", "DHO4404",
  "DHO4504", "DHO4804", "MSO8064", "MSO8064A", "MSO8104", "MSO8104A",
  "MSO8204", "MSO8204A", "MSO8304A",
  NULL
};

char         *scope_options[] = {
  "BND", "MSO", "COMP", "EMBD", "AUTO", "FLEX", "AUDIO", "AERO", "ARINC", "DG",
  "JITTER", "EYE", "RTSA", "CM_USB", "CM_ENET", "CM_MIPI", "CM_HDMI", "PWR",
  "UPA", "RLU", "BODE", "BW7T10", "BW7T15", "BW7T20", "BW10T20", "BW15T25",
  "BW2T4", "BW2T8", "BW4T8", "COUNT",
  NULL
};

char         *series800_options[] = {
  "BND", "RLU", "BW7T10", "EMBD", "AUTO", "COMP",
  NULL
};

char         *series900_options[] = {
  "BND", "BW15T25", "EMBD", "AUTO", "COMP", "BODE",
  NULL
};

char         *series1000_options[] = {
  "BND", "BW7T10", "BW7T20", "BW10T20", "RLU", "EMBD", "AUTO", "COMP",
  NULL
};

char         *series4000_options[] = {
  "BND", "BW2T4", "BW2T8", "BW4T8", "RLU", "EMBD", "AUTO", "COMP", "AERO",
  "FLEX", "AUDIO", "UPA",
  NULL
};

//   "DHO Series ADB Service IP:",
//   "adb connect %s:55555",
//   "adb -s %s:55555 shell",
//   "adb -s %s:55555 pull %s/Key.data %s/Key.data",
//   "adb -s %s:55555 pull %s/vendor.bin %s/vendor.bin",
//   "/rigol/data/vendor.bin",
//   "/rigol/data/Key.data",
//   "adb -s %s:55555 pull %s/%s %s/%s",
//   "/%s.lic",
//   "/Key.data",
