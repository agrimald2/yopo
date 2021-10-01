<template>
  <div class="m-1 max-w-lg mx-auto">
    <div class="yopoModal border-4 border-black rounded-xl pb-6">
      <div class="bg-black uppercase text-modal tracking-widest py-4 text-2xl text-center">
        Personaliza tu Orden
      </div>

      <div class="mt-3 text-2xl text-center">
        {{ product.name }}
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
                + S/. {{ option.price }} -
                {{ option.option }}
              </option>
            </select>
          </div>
        </div>
      </div>

      <div
        class="mt-4"
        v-show="product.aditionals.length"
      >

        <div class="text-2xl text-center bg-black text-yellow-400 py-2 uppercase tracking-wide">
          Productos Adicionales
        </div>

        <div class="mt-3 px-6 grid gap-12">
          <div
            v-for="aditional in product.aditionals"
            :key="aditional.id"
          >
            <Aditional
              :model="aditional"
              v-model="aditionals[aditional.id]"
            />
          </div>
        </div>

      </div>

      <div class="mt-8 text-center">
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
import Aditional from "./Components/Aditional.vue";

export default {
  props: ["product"],
  emits: ["added"],

  components: {
    Aditional
  },

  data() {
    return {
      input: {},
      aditionals: {}
    };
  },

  methods: {
    onAddToCart() {
      const isValid = this.product.questions.every(x => {
        return this.input.hasOwnProperty(x.question);
      });

      if (!isValid) {
        return alert("Responde todas las preguntas, por favor");
      }

      this.$emit("added", this.input);

      // Add values

      Object.keys(this.aditionals).forEach(id => {
        const qty = this.aditionals[id];

        if (qty <= 0) return;

        const data = {
          product: {
            id: id,
            counter: qty,
            options: null
          }
        };

        axios.post("shoppings", data);
      });
    }
  }
};
</script>
