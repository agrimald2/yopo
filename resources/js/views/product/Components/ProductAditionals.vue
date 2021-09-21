<template>
  <div>
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

