<template>
  <div>
    <div class="text-2xl text-center">Añadir un producto adicional</div>
    <div class="mt-6"></div>
    <Autocomplete @picked="attach" />

    <!-- Aditionals list -->

    <div class="mt-6 text-2xl text-center">Productos Adicionales Actuales</div>
    <div class="mt-3 grid gap-4">
      <div
        class="text-gray-500 text-center"
        v-if="aditionals.length == 0"
      >
        Sin productos adicionales.
      </div>
      <div
        v-else
        class="border rounded flex items-center p-2 gap-4"
        v-for="product in aditionals"
        :key="product.id"
      >
        <div class="font-bold text-sm">S/. {{ product.sale_price }}</div>
        <div class="flex-grow">{{ product.name }}</div>
        <div
          class="underline text-red-500 cursor-pointer"
          @click="detach(product.id)"
        >Quitar</div>
      </div>
    </div>

  </div>
</template>

<script>
import Autocomplete from "./Autocomplete.vue";

export default {
  props: ["id"],

  components: {
    Autocomplete
  },

  data() {
    return {
      aditionals: []
    };
  },

  mounted() {
    const url = `products/aditionals/${this.id}`;
    axios.get(url).then(response => (this.aditionals = response.data));
  },

  methods: {
    attach(id) {
      const url = `products/aditionals/${this.id}/attach`;
      axios
        .post(url, { id })
        .then(response => (this.aditionals = response.data));
    },

    detach(id) {
      const url = `products/aditionals/${this.id}/detach`;
      axios
        .post(url, { id })
        .then(response => (this.aditionals = response.data));
    }
  }
};
</script>

