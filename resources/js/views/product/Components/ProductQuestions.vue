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
        v-for="question in questions"
        :key="question.id"
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
  props: ["product_id", "questions"],

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
      const url = "/products/questions/add";
      axios
        .post(url, {
          product_id: this.product_id,
          question: input,
        })
        .then((res) => {
          this.questions.push(res.data);
          this.loading = false;
        });
    },

    addOption(done, question, input) {
      const url = "/products/questions/options/add";

      axios
        .post(url, {
          question_id: question.id,
          option: input,
        })
        .then((res) => {
          question.options.push(res.data);
          done();
        });
    },

    deleteOption(done, question, option) {
      const url = "/products/questions/options/remove";

      axios
        .post(url, {
          id: option.id,
        })
        .then((res) => {
          question.options.splice(
            question.options.findIndex((x) => x === option),
            1
          );
          done();
        });
    },

    deleteQuestion(done, question) {
      const url = "/products/questions/remove";

      axios
        .post(url, {
          id: question.id,
        })
        .then((res) => {
          this.questions.splice(
            this.questions.findIndex((x) => x === question),
            1
          );
          done();
        });
    },
  },
};
</script>
