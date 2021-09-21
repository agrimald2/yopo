<template>
  <div class="flex items-stretch gap-4">
    <i
      @click="add(-1)"
      class="cursor-pointer flex items-center bg-gray-900 text-yellow-400 rounded p-2 fas fa-minus"
    ></i>
    <div
      class="cursor-pointer select-none w-14 py-1 text-center bg-gray-900 text-yellow-400 px-2 text-3xl rounded"
      @click="$emit('input', 0)"
    >
      {{ value }}
    </div>
    <i
      @click="add(1)"
      class="cursor-pointer flex items-center bg-gray-900 text-yellow-400 rounded p-2 fas fa-plus"
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
