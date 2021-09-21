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
        v-for="x in 4"
      >
        <div class="font-bold text-sm">S/. 40</div>
        <div class="flex-grow">Pollo Frito</div>
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

