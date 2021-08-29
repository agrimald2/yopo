<template>
  <div class="border-2 pb-4 rounded">
    <loading
      class="mt-4"
      v-if="loading"
    />
    <div v-else>
      <div class="text-xl border-b-2 py-3 px-4">
        <div class="flex justify-between items-center">
          <div class="grid">
            <div class="text-xs font-bold tracking-widest">PREGUNTA:</div>
            <div>{{ question.question }}</div>
          </div>
          <div
            class="underline text-red-500 cursor-pointer"
            @click="deleteQuestion(question)"
          >
            Eliminar
          </div>
        </div>
      </div>

      <div class="text-xs font-bold tracking-widest text-center py-2">
        POSIBLES OPCIONES:
      </div>
      <div class="grid">
        <div
          v-for="(option, option_key) in question.options"
          :key="option_key"
          class="flex justify-between py-4 border-b px-4"
        >
          <div>
            {{ option.option }}
          </div>
          <div
            class="underline text-red-500 cursor-pointer"
            @click="deleteOption(question, option)"
          >
            Eliminar
          </div>
        </div>
      </div>
      <form @submit.prevent="addOption(question)">
        <div class="mt-4 flex items-center gap-4 px-8">
          <input
            class="flex-grow border py-2 px-3"
            type="text"
            v-model="input.option"
          />
          <button
            type="submit"
            class="rounded border px-4 py-2 cursor-pointer hover:bg-gray-100"
          >
            Añadir opción
          </button>
        </div>
      </form>
    </div>
  </div>
</template>


<script>
import Loading from "./Loading.vue";

export default {
  props: ["question"],

  emits: ["option-add", "option-delete", "question-delete"],

  components: {
    Loading,
  },

  data() {
    return {
      input: {
        option: null,
      },
      loading: false,
    };
  },

  methods: {
    done() {
      this.loading = false;
    },

    addOption(question) {
      const input = this.input.option;
      if (input === "") return;

      this.loading = true;
      this.$emit("option-add", this.done, question, input);

      this.input.option = "";
    },

    deleteOption(question, option) {
      this.loading = true;
      this.$emit("option-delete", this.done, question, option);
    },

    deleteQuestion(question) {
      this.loading = true;
      this.$emit("question-delete", this.done, question);
    },
  },
};
</script>
