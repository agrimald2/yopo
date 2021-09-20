<template>
  <div class="grid">
    <input
      type="text"
      class="border p-2"
      v-model="query"
      @keyup.enter="pickFocusedResult"
      @keyup.up="onKeyUp"
      @keyup.down="onKeyDown"
    />
    <div
      class="results border"
      v-show="results.length"
    >
      <div
        class="border-b px-4 py-2 hover:bg-gray-100 cursor-pointer"
        :class="{'bg-yellow-200': key == focusIndex}"
        v-for="result, key in results"
        :key="result.id"
        @click="pickResult(result)"
      >
        {{ result[$props.completeValue] }}
      </div>
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
