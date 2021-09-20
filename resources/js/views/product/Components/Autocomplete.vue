<template>
  <div class="flex items-center">

    <div>
      <input
        type="text"
        class="border px-3"
      >
    </div>

    <div class="bg-gray-800 text-white">
      Añadir
    </div>

  </div>
</template>


<script>
import axios from "axios";

export default {
  emits: ["update:modelValue"],

  props: {
    url: String,

    modelValue: Object,

    completeValue: {
      type: String,
      default: "name"
    }
  },

  data() {
    return {
      query: "",
      results: [],
      picked: null,
      focusIndex: 0
    };
  },

  watch: {
    query(value) {
      if (this.picked && this.picked[props.completeValue] == value) return;

      if (typeof this.axiosCancelToken != typeof undefined) {
        this.axiosCancelToken.cancel("Canceled due to new req.");
      }

      this.axiosCancelToken = axios.CancelToken.source();

      console.log(this.clearResults);
      this.clearResults();
      this.picked = null;

      emit("update:modelValue", null);

      if (value == "") return;

      axios
        .post(
          props.url,
          { query: value },
          { cancelToken: this.axiosCancelToken.token }
        )
        .then(response => {
          this.results = response.data;
        });
    }
  },

  setup(props, { emit }) {
    let axiosCancelToken;

    function clearResults() {
      this.results = [];
      this.focusIndex = 0;
    }

    function pickResult(result) {
      if (this.picked) return;

      this.picked = result;
      this.query = result[props.completeValue];
      emit("update:modelValue", result);
      clearResults();
    }

    function pickFocusedResult() {
      pickResult(this.results[this.focusIndex]);
    }

    function onKeyUp() {
      this.focusIndex--;
      if (this.focusIndex < 0) {
        this.focusIndex = Math.max(this.results.length - 1, 0);
      }
    }

    function onKeyDown() {
      this.focusIndex++;
      if (this.focusIndex >= this.results.length) {
        this.focusIndex = 0;
      }
    }

    return {
      axiosCancelToken,

      pickResult,

      clearResults,

      onKeyUp,
      onKeyDown,
      pickFocusedResult
    };
  }
};
</script>
