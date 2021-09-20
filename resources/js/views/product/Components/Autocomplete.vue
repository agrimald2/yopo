<template>
  <div>
    <div class="grid">

      <input
        type="text"
        v-model="query"
        class="border px-3 py-2"
        placeholder="Buscar un producto..."
      >

    </div>

    <div
      class="mt-2 border p-2"
      v-show="results.length"
    >

      <div class="grid gap-4">
        <div
          class="border border-gray-800 p-2 rounded flex gap-3 items-center
          cursor-pointer hover:bg-gray-300"
          v-for="item in results"
          :key="item.id"
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
  data() {
    return {
      query: "",
      results: [],
      url: "products/autocomplete"
    };
  },

  watch: {
    query() {
      const input = this.query;

      // Clear results
      this.clearResults();

      // Make request
      axios.post(this.url, { input }).then(response => {
        this.results = response.data;
      });
    }
  },

  methods: {
    clearResults() {
      this.results = [];
    }
  }
};
</script>
