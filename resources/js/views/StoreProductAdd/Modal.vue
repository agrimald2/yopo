<template>
  <div class="">
    <div class="yopoModal border-4 border-black rounded-xl">
      <div class="bg-black uppercase text-modal tracking-widest py-4 text-2xl text-center">
        Personaliza tu Orden
      </div>

      <div class="p-4">
        <div
          class="mt-4"
          v-for="(question, key) in questions"
          :key="key"
        >
          <div class="bg-black uppercase inline-block text-xl text-modal p-2 rounded">
            {{ question.question }}
          </div>

          <div class="mt-2">
            <select
              v-model="input[question.question]"
              class="block w-full p-2 text-xl rounded"
            >
              <option
                :value="option.option"
                v-for="(option, key) in question.options"
                :key="key"
              >
                {{ option.option }}
              </option>
            </select>
          </div>
        </div>
      </div>

      <div class="mt-4 text-center">
        <div
          class="bg-black text-modal inline-block px-4 py-3 rounded border-b-4 border-yellow-700 cursor-pointer hover:-translate-y-1 transform transition"
          @click="onAddToCart"
        >
          Añadir al carrito
        </div>
      </div>

      <div class="mt-4 text-sm bg-black text-white p-2">
        {{ input }}
      </div>
    </div>
  </div>
</template>


<style scoped>
.yopoModal {
  background-color: #ddc237;
}
.text-modal {
  color: #ddc237;
}
</style>

<script>
export default {
  props: ["questions"],

  data() {
    return {
      input: {},
    };
  },

  methods: {
    onAddToCart() {
      alert("Añadido!");
    },
  },
};
</script>
