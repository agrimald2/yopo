<template>
  <div class="flex items-center gap-4">
    <div class="grid">
      <counter v-model="qty" />
      <div
        class="mt-2 flex justify-center"
        v-show="qty"
      >
        <div class="text-lg bg-black text-yellow-400 px-2 rounded border-black">
          + S/. {{ model.sale_price * qty }}
        </div>
      </div>
    </div>

    <div
      class="w-20 h-20 flex items-center bg-cover bg-center"
      :style="{ backgroundImage: `url('/api/products/${model.image_url}')`}"
    >
    </div>

    <div class="text-xl font-bold flex-grow">
      {{ model.name }}
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
