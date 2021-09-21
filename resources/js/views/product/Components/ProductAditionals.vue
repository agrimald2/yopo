<template>
  <div>
    <div class="text-2xl">Añadir un producto adicional</div>
    <div class="mt-6"></div>
    <Autocomplete @picked="onAditionalPicked" />

    <!-- Aditionals list -->

    <div class="mt-6 text-2xl">Productos Adicionales Actuales</div>
    <div class="mt-3 grid gap-4">
      <div
        class="border rounded flex items-center p-2 gap-4"
        v-for="product in model.aditionals"
        :key="product.id"
      >
        <div class="font-bold text-sm">S/. {{ product.sale_price }}</div>
        <div class="flex-grow">{{ product.name }}</div>
        <div
          class="underline text-red-500 cursor-pointer"
          @click="onDelete"
        >Quitar</div>
      </div>
    </div>

  </div>
</template>

<script>
import Autocomplete from "./Autocomplete.vue";

export default {
  props: ["id", "model"],

  components: {
    Autocomplete
  },

  methods: {
    onAditionalPicked(id) {
      alert(id);
    },

    onDelete() {
      alert("delete");
    }
  }
};
</script>

