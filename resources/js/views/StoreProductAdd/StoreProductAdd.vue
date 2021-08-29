<template>
  <div>
    <modal
      :product="product"
      @added="onAdded"
    />
  </div>
</template>


<script>
import Modal from "./Modal.vue";

export default {
  components: {
    Modal,
  },
  mounted() {
    this.fetchData();
  },
  data() {
    return {
      id: this.$route.params.id,
      product: {},
    };
  },
  methods: {
    fetchData() {
      const url = `products/${this.id}`;
      axios.get(url).then((res) => (this.product = res.data.product));
    },
    onAdded(input) {
      console.log(input);
    },
  },
};
</script>
