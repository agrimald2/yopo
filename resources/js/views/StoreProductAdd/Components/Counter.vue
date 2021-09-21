<template>
  <div class="flex items-center gap-4">
    <i
      @click="add(-1)"
      class="cursor-pointer bg-gray-900 text-yellow-400 rounded p-2 fas fa-minus"
    ></i>
    <div class="w-14 py-1 text-center bg-gray-900 text-yellow-400 px-2 text-3xl rounded">
      {{ value }}
    </div>
    <i
      @click="add(1)"
      class="cursor-pointer bg-gray-900 text-yellow-400 rounded p-2 fas fa-plus"
    ></i>
  </div>
</template>


<script>
export default {
  props: {
    value: {
      default: 0
    }
  },

  emits: ["input"],

  methods: {
    add(qty = 1) {
      let count = this.value + qty;

      if (count < 0) {
        count = 0;
      }

      this.$emit("input", count);
    }
  }
};
</script>
