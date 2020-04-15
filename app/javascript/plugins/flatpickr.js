import flatpickr from "flatpickr"
import rangePlugin from "flatpickr/dist/plugins/rangePlugin"

flatpickr("#start_time", {
  altInput: true,
  "plugins": [new rangePlugin({ input: "#end_time"})]
});
