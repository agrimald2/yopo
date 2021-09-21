<template>
  <div>
    <div class="text-2xl">Adicionales del Producto</div>
    <div class="mt-6"></div>
    <Autocomplete @picked="onAditionalPicked" />
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
    }
  }
};
</script>

