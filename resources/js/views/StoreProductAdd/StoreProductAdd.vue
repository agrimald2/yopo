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
      this.loading = false;
      this.product = product;
      if (product.questions.length === 0) {
        this.submitProductToCart();
      }
    });
  },
  methods: {
    fetchData() {
      const url = `products/${this.id}`;
      return new Promise((resolve, reject) => {
        axios.get(url).then((res) => {
          resolve(res.data.product);
        });
      });
    },

    onModalAdded(input) {
      this.submitProductToCart(input);
    },

    submitProductToCart(options = {}) {
      console.log("XXXXXXXXXXX", {
        product_id: this.id,
        qty: this.qty,
        options,
      });

      const icon = `https://image.flaticon.com/icons/png/128/117/117645.png?ga=GA1.2.247189466.1619654400`;
      const msg = `${this.qty} "${this.product.name}" al carrito!`;
      this.$snotify.warning(msg, null, {
        icon: icon,
      });
      /**
       * Todo:
       * - Add to vuex (local cart)
       * - Send to laravel (remote cart)
       */
      //let doc = Object.assign({}, product);
      //this.addProduct(doc);
      // axios.post("shoppings", { product: doc });

      this.redirectToStore();
    },

    redirectToStore() {
      this.$router.push({ name: "store" });
    },
  },
};
</script>
