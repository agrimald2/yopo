<template>
  <div>
    <div
      class="text-yellow-400 py-12"
      v-if="loading"
    >
      <loading />
    </div>
    <modal
      v-else
      :product="product"
      @added="onModalAdded"
    />
  </div>
</template>


<script>
import Modal from "./Modal.vue";
import Loading from "@/views/product/Components/Loading.vue";
import { mapGetters, mapActions } from "vuex";

export default {
  components: {
    Modal,
    Loading,
  },
  data() {
    return {
      id: this.$route.params.id,
      qty: this.$route.params.qty,
      product: {},
      loading: true,
    };
  },
  mounted() {
    this.fetchData().then((product) => {
      this.product = product;
      if (product.questions.length > 0) {
        this.loading = false;
      } else {
        this.submitProductToCart();
      }
    });
  },
  methods: {
    ...mapActions({
      vuexAddProduct: "sale/addProduct",
    }),

    fetchData() {
      const url = `products/${this.id}`;
      return new Promise((resolve, reject) => {
        axios.get(url).then((res) => {
          resolve(res.data.product);
        });
      });
    },

    onModalAdded(input) {
      const options = Object.keys(input)
        .map((key) => `${key}: ${input[key]}`)
        .join("\n");
      this.submitProductToCart(options);
    },

    submitProductToCart(options = null) {
      const data = {
        product: {
          id: this.id,
          counter: this.qty,
          options,
        },
      };

      axios.post("shoppings", data).then((res) => {
        this.addToLocalCart(this.product);
        this.showSuccessToast();
        this.redirectToStore();
      });
    },

    addToLocalCart(product) {
      this.vuexAddProduct(Object.assign({ counter: this.qty }, product));
    },

    showSuccessToast() {
      const icon = `https://image.flaticon.com/icons/png/128/117/117645.png?ga=GA1.2.247189466.1619654400`;
      const msg = `${this.qty} "${this.product.name}" al carrito!`;
      this.$snotify.warning(msg, null, {
        icon: icon,
      });
    },

    redirectToStore() {
      this.$router.push({ name: "store" });
    },
  },
};
</script>
