<template>
  <div class="flex items-center gap-4">
    <i
      @click="add(-1)"
      class="cursor-pointer bg-gray-900 text-yellow-400 rounded p-2 fas fa-minus"
    ></i>
    <div class="bg-gray-900 text-yellow-400 px-2 text-xl rounded">
      {{ count }}
    </div>
    <i
      @click="add(1)"
      class="cursor-pointer bg-gray-900 text-yellow-400 rounded p-2 fas fa-plus"
    ></i>
  </div>
</template>


<script>
export default {
  data() {
    return {
      count: 0
    };
  },

  methods: {
    add(qty = 1) {
      let count = this.count + qty;

      if (count < 0) {
        count = 0;
      }

      this.count = count;
    }
  }
};
</script>
