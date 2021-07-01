<template>
<div id="card-product">
  <div class="row top-y">
    <div class="col-8">
      <h3 style="position: relative;">
        {{ product.name }}
      </h3>
    </div>
  </div>
  <div class="row sub-y">
    <div class="product_card row" style="width:100%;height:100%">
      <div class="col-8">
        <img :src="src" :alt="product.name">
      </div>
      <div class="col-4" style="justify-content: center; align-items: center; display: flex;">
        <div class="product_info">
          <h1>
            S/ {{ product.sale_price.toFixed(2) }}
          </h1>
          <hr>
          <p>
            {{ product.description }}
          </p>
          <div class="row" style="text-align: center; display: flex; align-items: center; margin-top:5px">
            <div class="col-4" style="color: black; font-family: EATHOMASANS; font-size:0.85rem">
                <div class="btn counter">
                  {{ localProduct.counter || 0 }}
                </div>
            </div> 
            <button @click="minusP(localProduct); $forceUpdate()" class="col-3 btn_maths" style="color: #ddc237;">
              <span>
                <i class="fas fa-minus-square"></i>
              </span>
            </button> 
            <button @click="plusP(localProduct); $forceUpdate()" class="col-3 btn_maths">
              <span>
                <i class="fas fa-plus-square" style="color: #ddc237;"></i>
              </span>
            </button> 

          </div>
          <div class="btn btn_add" @click="addP(localProduct); $forceUpdate()">
            agregar
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</template>
<script>
import { mapActions } from 'vuex'

export default {
  props: ['product'],
  mounted() {
    this.localProduct = Object.assign({
      counter: 0,
    }, this.product);
  },
  data() {
    return {
      localProduct: {},
      counter: 0,
      message: 'Agregar'
    }
  },
  computed: {
    src() {
      if (this.product.image_url) {
        return `/api/products/${this.product.image_url}`;
      } else {
        return "@/assets/img/1.jpg";
      }
    }
  },
  methods: {
    ...mapActions({
      addProduct: 'sale/addProduct',
      addProduct: 'sale/addProduct',
      plusProduct: 'sale/plusProduct',
      minusProduct: 'sale/minusProduct',
    }),
    addP(product) {
      let doc = Object.assign({}, product);
      this.addProduct(doc);
      const icon = `https://image.flaticon.com/icons/png/128/117/117645.png?ga=GA1.2.247189466.1619654400`;
      this.$snotify.warning('Agregado', null, {
      icon: icon
      });
      product.counter = 0;
      axios.post('shoppings', { product: doc }).catch(err => {
        console.log(err.response);
      });
    },
    plusP(product) {
      if (product.unit_code == 'KGM') {
        product.counter += 0.5;
      } else {
        product.counter += 1;
      }
    },
    minusP(product) {
      if (product.unit_code == 'KGM') {
        if (product.counter >= 0.5) {
          product.counter -= 0.5;
        }
      } else {
        if (product.counter >= 1) {
          product.counter -= 1;
        }
      }
    }
  }
}
</script>

<style scoped>
.btn_maths{
    padding-left: 0;
    border: none;
    padding-right: 0px;
    padding-bottom: 0px;
    padding-top: 0px;
    border-bottom-width: 0px;
    background-color: #2d2107;
}
.counter{
  background-color: #ddc237;
  padding-right: 5px;
  padding-left: 5px;
  font-size: 0.75rem;
  padding-top: 0px;
  margin-bottom: 5px;
  padding-bottom: 0px;
}
i{
  font-size: 1.5rem;
}
.btn_add{
  font-size: 0.85rem;
  margin-top: 3px;
  margin-bottom: 2px;
  background-color: black;
  color: #ddc237;
  font-family: EATHOMASANS;
}
p{
    color: white;
    font-size: 0.45rem;
    text-align: center;
    font-family: 'EATHOMASANS';
    padding-left: 7px;
    padding-right: 7px;
    margin-bottom: 0;
}
hr{
    margin-top: 0.5rem;
    margin-bottom: 0.5rem;
    border: 6px solid #7f670e;
    border-top: 1px solid #7f670e;
    width: 75%;
    color: #7f670e;
    background-color: #7f670e;
}
.col-8{
  padding: 0;
  /*display: flex;*/
}
.col-8 img{
  width: 100%;
  height: 100%;
  border-radius: 5px;
}
.col-4{
    padding-right: 0px;
    padding-left: 10px;
}
.col-6{
    justify-content: center;
    display: flex;
    align-items: center;
    padding-left: 0px;
    justify-content: center;
}
h3{
    border-radius: 5px;
    font-family: 'EATHOMASANS';
    background-color: #ddc237;
    padding: 5px;
    text-align: center;
    font-size: 0.8rem;
}
.row{
  margin: 0;
}
#card-product{
  width: 100%;
  height: 100%;
}
.top-y{
  width: 100%;
  height: 20%;
}
.sub-y{
  width: 100%;
  background-color: #b69816;
}
.sub-y .product_card{
    padding: 5px;
}
.product_info{
  text-align: center;
  padding-top: 15px;
  background-color: #2d2107;  
  /*background-color: black;
  opacity: 65%;*/
  border-radius: 5px;
}
.product_info h1{
  font-family: EathomaSans;
  font-size: 1rem;
}
h1{
  color: #ddc237;
}
</style>