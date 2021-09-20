<template>
  <div>
    <div class="flex items-stretch gap-2">

      <input
        type="text"
        v-model="query"
        class="border px-3 py-2 flex-grow"
      >

      <div class="cursor-pointer flex items-center bg-gray-800 px-3 rounded text-white">
        Añadir
      </div>

    </div>

    <div class="mt-4">
      Hola
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

      // If empty return
      if (input == "") return;

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
