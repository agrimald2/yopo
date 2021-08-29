<template>
  <div class="mt-6 px-4">
    <div class="">
      <div class="text-3xl">Preguntas del Producto</div>
      <div class="mt-2 text-gray-500 sm:w-3/4">
        Permite que el cliente seleccione exactamente como quiere su orden.
        <br />
        <br />
        <span class="">¡Añade una nueva pregunta!</span>
      </div>
    </div>
    <form
      @submit.prevent="onSubmitQuestionForm"
      class="mt-4"
    >
      <loading v-if="loading" />
      <div
        class="flex items-center gap-4"
        v-else
      >
        <input
          class="flex-grow border py-2 px-3"
          type="text"
          v-model="input.question"
        />
        <button
          type="submit"
          class="rounded border px-4 py-2 cursor-pointer hover:bg-gray-100"
        >
          Añadir pregunta
        </button>
      </div>
    </form>

    <div class="py-6">
      <div class="text-center text-sm font-bold tracking-widest">
        PREGUNTAS ACTUALES:
      </div>
    </div>

    <div class="grid gap-8">
      <question-item
        v-for="(question, key) in questions"
        :key="key"
        :question="question"
        @option-add="addOption"
        @option-delete="deleteOption"
        @question-delete="deleteQuestion"
      />
    </div>

  </div>
</template>

<script>
import QuestionItem from "./QuestionItem.vue";
import Loading from "./Loading.vue";

export default {
  components: {
    QuestionItem,
    Loading,
  },

  data() {
    return {
      loading: false,
      input: {
        question: null,
        option: null,
      },
      questions: [
        {
          question: "Selecciona un Refresco",
          options: [
            { option: "Manzanita" },
            { option: "Coca Cola" },
            { option: "Sprite" },
          ],
        },
        {
          question: "Selecciona una Salsa",
          options: [
            { option: "Verde" },
            { option: "Roja" },
            { option: "Tomate Picosa" },
          ],
        },
      ],
    };
  },

  methods: {
    onSubmitQuestionForm() {
      const input = this.input.question;
      if (input === "") return;

      this.addQuestion(input);

      this.input.question = "";
    },

    addQuestion(input) {
      this.loading = true;
      setTimeout(() => {
        this.questions.push({
          question: input,
          options: [],
        });
        this.loading = false;
      }, 1000);
    },

    addOption(done, question, input) {
      setTimeout(() => {
        question.options.push({
          option: input,
        });
        done();
      }, 1000);
    },

    deleteOption(done, question, option) {
      setTimeout(() => {
        question.options.splice(
          question.options.findIndex((x) => x === option),
          1
        );
        done();
      }, 1000);
    },

    deleteQuestion(done, question) {
      setTimeout(() => {
        this.questions.splice(
          this.questions.findIndex((x) => x === question),
          1
        );
        done();
      }, 1000);
    },
  },
};
</script>
