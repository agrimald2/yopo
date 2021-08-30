<template>
  <div class="m-1 max-w-lg mx-auto">
    <div class="yopoModal border-4 border-black rounded-xl pb-6">
      <div class="bg-black uppercase text-modal tracking-widest py-4 text-2xl text-center">
        Personaliza tu Orden
      </div>

      <div class="mt-3 text-2xl text-center">
        "{{ product.name }}"
      </div>

      <div class="px-4">
        <div
          class="mt-4"
          v-for="(question, key) in product.questions"
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
          class="bg-black uppercase tracking-wide text-modal inline-block px-4 py-3 rounded border-b-4 border-yellow-700 cursor-pointer hover:-translate-y-1 transform transition"
          @click="onAddToCart"
        >
          <i class="fas fa-plus mr-2"></i>
          Añadir al carrito
        </div>
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
  props: ["product"],
  emits: ["added"],

  data() {
    return {
      input: {},
    };
  },

  methods: {
    onAddToCart() {
      const isValid = this.product.questions.every((x) => {
        return this.input.hasOwnProperty(x.question);
      });

      if (!isValid) {
        return alert("Responde todas las preguntas, por favor");
      }

      this.$emit("added", this.input);
    },
  },
};
</script>
