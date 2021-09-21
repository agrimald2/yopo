<template>
  <div class="flex items-center gap-4">
    <counter v-model="qty" />

    <div class="text-xl font-bold flex-grow">
      {{ model.name }}
    </div>

    <div
      class="flex items-center"
      v-show="qty"
    >
      <div class="text-2xl bg-black flex items-center text-yellow-400 px-2 rounded border-black">
        <div class="pr-2">+</div>
        S/. {{ model.sale_price * qty }}
      </div>
    </div>
  </div>
</template>

<style scoped>
.borderr {
  border-width: 1px;
}
</style>

<script>
import Counter from "./Counter.vue";

export default {
  props: ["model"],

  components: {
    Counter
  },

  data() {
    return {
      qty: 0
    };
  }
};
</script>
