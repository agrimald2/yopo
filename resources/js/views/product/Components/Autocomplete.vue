<template>
  <div>
    <div class="grid">

      <input
        type="text"
        v-model="query"
        class="border px-3 py-2"
        placeholder="Buscar un producto..."
        @blur="onBlur"
        @focus="queryResults"
      >

    </div>

    <div
      class="mt-2 px-2 py-2 bg-gray-100 rounded"
      v-show="results.length"
    >

      <div class="grid gap-4">
        <div
          class="border border-gray-800 py-2 px-3 rounded flex gap-3 items-center
          cursor-pointer hover:text-green-400 text-lg justify-center"
          style="background-color: white;"
          v-for="item in results"
          :key="item.id"
          @click="pick(item.id)"
        >
          <i class="fas fa-arrow-right"></i>
          {{ item.name }}
        </div>
      </div>

    </div>

  </div>
</template>


<script>
export default {
  emits: ["picked"],

  data() {
    return {
      query: "",
      results: [],
      url: "products/autocomplete",
      lastTimestamp: null
    };
  },

  watch: {
    query() {
      this.queryResults();
    }
  },

  methods: {
    onBlur() {
      setTimeout(this.clearResults, 800);
    },

    queryResults() {
      const input = this.query;

      // Clear results
      this.clearResults();

      // Make request
      let timestamp = Date.now();
      this.lastTimestamp = timestamp;

      axios.post(this.url, { input }).then(response => {
        if (this.lastTimestamp <= timestamp) {
          this.results = response.data;
        }
      });
    },

    clearResults() {
      this.results = [];
    },

    pick(id) {
      this.$emit("picked", id);
      this.clearResults();
      this.query = "";
    }
  }
};
</script>
