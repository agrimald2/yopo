<template>
<div>
  <!--<checkout-modal description="YOPO.PE" :transaction-amount="totalProducts + (sale.delivery_price || 0)" :sale="sale" @confirm="successCheckout" @error="errorCheckout"/>-->
  <customer-modal @confirm="submit"/>
  <div class="row d-sm-block d-md-none" style="background-color: #ddc237; min-height:100vh">
    <nav class="navbar navbar-expand-md navbar-light shadow-sm fixed-top store_topbar">
      CARRITO
      <router-link to="/shopping" class="d-flex align-items-center" style="color: black; font-size: 0.8rem; position:fixed; right:20vw">
        <img src="@/assets/img/black_circle.png" alt="">
      </router-link>   
      <router-link to="/store" class="" >
        <i class="fas fa-arrow-circle-left" style="position: absolute;color: #ddc237;left: 3vw;top: 1px;font-size: 2rem;"></i>
      </router-link>   
    </nav>
    <div class="negro"></div>
    <div class="top_cart">
        <div class="row">
          <h4>PRODUCTOS</h4>
        </div>
        <div class="row container_list">
          <div class="row"  v-for="item in products" :key="item.id">
            <div class="col-7">
              <img :src="`/api/products/${item.image_url}`" :alt="item.name"> &nbsp {{ item.name }}
               &nbsp
              <div class="btn counter">
                   {{ item.counter }} 
              </div>
            </div>
            <div class="col-5 row">
              <div class="col-8">
                <button @click="plusP(item)" class="col-3 btn_maths">
                  <span>
                    <i class="fas fa-plus-square" style="color: #ddc237;"></i>
                  </span>
                </button>
                <button @click="minusP(item)" class="col-3 btn_maths" style="color: #ddc237;">
                  <span>
                    <i class="fas fa-minus-square"></i>
                  </span>
                </button> 
                <button @click="removeP(item)" class="col-3 btn_maths">
                  <span>
                    <i class="fas fa-trash" style="color: #ddc237;"></i>
                  </span>
                </button>
              </div>
              <div class="col-4">
                <span v-if="checkInventory(item).length">
                  S/{{ (checkInventory(item).map(e => e.weight).reduce((a, b) => a + b, 0) * item.sale_price).toFixed(2) }}
                </span>
                <span v-else style="color:red">
                  Agotado
                </span>
              </div>
            </div>            
          </div>
        </div>
    </div>
    <div class="bot_cart">
      <div class="row">
        <h4>RESUMEN</h4>
      </div>
      <div class="row sale_info">
          <div class="row">
            <div class="col-6" style="text-align:left">SUBTOTAL</div>
            <div class="col-6" style="text-align:right">S/  &nbsp {{ totalProducts.toFixed(2) }} </div>
          </div>
      </div>
      <div class="row wha_row">
        <button type="button" class="row" @click="checkDelivery">
          Concluir venta en Whatsapp &nbsp <i class="fab fa-whatsapp"></i>
        </button>
      </div>
        <img src="@/assets/img/left_esquina.png" alt="" id="left_esquina">
        <img src="@/assets/img/right_esquina.png" alt="" id="right_esquina">
    </div>
  </div>

  <div id="table_shopping" class="container d-none d-md-block">
    <table class='table' style="background-color: white; margin-top: 5vh;">
      <thead style="background-color:rgb(245, 166, 35)">
        <th style="text-align:center">#</th>
        <th>Producto Solicitado</th>
        <th colspan="1"> Solicitado</th>
        <th>Modificar Cantidad</th>
        <th colspan="1"> A Despachar</th>
        <th>Sub Total</th>
      </thead>
      <tbody>
        <tr v-for="(item, index) in products" :key="item.id">
          <td style="text-align:center">{{ index + 1 }}</td>
          <td class="text-truncate" style="max-width: 18rem">
            <img style="height: 5vh;" :src="`/api/products/${item.image_url}`" alt=""/>
            <span class="ml-2">{{ item.name }}</span>
          </td>
          <td>
            <p>
              {{ item.counter }} {{ item.short_unit }}
            </p>
          </td>
          <td>
            <button type="button" class="btn btn-sm btn-secondary" @click="removeP(item)">
              <feather type="trash-2"/>
            </button>
            <button type="button" class="btn btn-sm btn-secondary" @click="minusP(item)">
              <feather type="minus"/>
            </button>
            <button type="button" class="btn btn-sm btn-secondary" @click="plusP(item)">
              <feather type="plus"/>
            </button>
          </td>
          <td>
            <span class="text-success" v-if="checkInventory(item).length">{{ checkInventory(item).map(e => e.weight).reduce((a, b) => a + b, 0).toFixed(3) }} {{ item.short_unit }}</span>
            <span class="text-danger" v-else>No Disponible</span>
          </td>
          <td>
            S/ {{ (checkInventory(item).map(e => e.weight).reduce((a, b) => a + b, 0) * item.sale_price).toFixed(2) }}
          </td>
        </tr>
      </tbody>
      <tfoot>
        <tr>
          <td colspan="4"></td>
          <th scope="row">Total:</th>
          <td>S/ {{ totalProducts.toFixed(2) }}</td>
        </tr>
      </tfoot>
    </table>
    <div class="row">
      <div class="col d-flex justify-content-end">
        <router-link to="/store" class="btn my-3 cart_buttons mr-2" style="background-color: white !important">
          <feather type="chevron-left"/> 
          Seguir Comprando
        </router-link>
        <button type="button" class="btn btn-dark my-3 cart_buttons" @click="checkDelivery">
          <feather type='check'/>
          Pagar ahora
        </button>
      </div>
    </div>
  </div>
</div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import CustomerModal from '@/components/CustomerModal'
import CheckoutModal from '@/components/CheckoutModal'

export default {
  components: {
    CustomerModal,
    CheckoutModal,
  },
  mounted() {
    axios.get('shoppings').then(res => {
      console.log(res);
      this.removeAllProducts();
      var shoppings = res.data.shoppings;
      shoppings.forEach(item => {
        var product = item.product;
        if (product) {
          product.counter = item.counter;
          console.log(product);
          product.inventory = product.inventory_shop;
          // product.inventory = product.inventory_all.filter(e => e.office_id == 1);
          this.addProduct(product);
        }
      });
    });
  },
  data() {
    return {
      token: process.env.VUE_APP_TOKEN || 'TEST-dd114825-b697-4ce1-9f03-e5fce322b40f',
      delivery: null,
      customer: {},
      deliveries: [],
    }
  },
  computed: {
    ...mapGetters({
      sale: 'sale/getSale',
      products: 'sale/products',
      totalProducts: 'sale/totalProducts',
    }),
  },
  methods: {
    ...mapActions({
      removeAllProducts: 'sale/removeAllProducts',
      addProduct: 'sale/addProduct',
      plusProduct: 'sale/plusProduct',
      removeProduct: 'sale/removeProduct',
      setSale: 'sale/setSale',
      minusProduct: 'sale/minusProduct',
    }),
    checkDelivery() {
      $('#shoppingModal').modal('show');
    },
    removeP(product) {
      axios.delete(`shoppings/${product.id}`).catch(err => {
        console.log(err.response);
      });
      this.removeProduct(product);
    },
    plusP(product) {
      console.log(product);
      this.plusProduct(product);
      axios.post('shoppings', { product }).catch(err => {
        console.log(err.response);
      });
    },
    minusP(product) {
      this.minusProduct(product);
      axios.post('shoppings', { product }).catch(err => {
        console.log(err.response);
      });
    },
    successCheckout(data) {
      this.$router.replace(`/${data.sale.id}/checkoutDetails`);
      axios.get('shoppings/removeAll').catch(err => {
        console.log(err.response);
      });
      this.removeAllProducts();
      console.log(data);
      location.reload();
    },
    errorCheckout(error) {
      console.log(data);
    },
    submit(sale) {
      var inventories = [];
      this.products.forEach(item => {
        inventories.push(...this.checkInventory(item));
      });
      if (inventories.length) {
        console.log('submit(sale) ==>');
        this.setSale(sale);
        $('.modal').modal('hide');
        $('#checkoutModal').modal('show');
      } else {
        this.$snotify.error('Debe haber almenos un producto disponible');
        $('.modal').modal('hide');
      }
      this.$loading(false);
    },
  }
}
</script>

<style scoped>
.sale_info{
    align-items: center;
    justify-content: center;
    padding: 10px;
}

.sale_info .row{
  width: 100%;
  background-color: black;
  padding: 10px;
  color: #ddc237;
  font-family: 'EATHOMASANS';
  font-size: 0.75rem;
  border-radius: 5px;
}
.bot_cart{
  position: fixed;
  bottom: 0;
  width: 100vw;
  padding-bottom: 7vh;
  background-color: #ddc237;
}
.wha_row{
      justify-content: center;
}
.wha_row .row{
  background-color: black;
  padding: 10px;
  color: #ddc237;
  font-family: 'EATHOMASANS';
  font-size: 0.65rem;
  border-radius: 5px;
}
#left_esquina{
  position: fixed;
  left: 0px;
  width: 15vw;
  bottom: 0;
}
#right_esquina{
  position: fixed;
  right: 0px;
  width: 15vw;
  bottom: 0;
}
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
  margin-bottom: 9px;
  padding-bottom: 0px;
}
i{
  font-size: 1.2rem;
}
.btn_add{
  font-size: 0.85rem;
  margin-top: 3px;
  margin-bottom: 2px;
  background-color: black;
  color: #ddc237;
  font-family: EATHOMASANS;
}
.col-4{
  padding: 0;
  padding-right: 5px;
}
.col-5{
  padding-right: 0;
  padding-left: 0;
  justify-content: center;
  display: flex;
  align-items: center;
}
.col-7{
  justify-content: left;
  display: flex;
  align-items: center;
}
.col{
  padding-right: 0;
}
.container_list{
    border-radius: 10px;
    color: #ddc237;
    padding-left: 10px;
    width: 100vw;
    padding-right: 10px;
    font-family: 'EATHOMASANS';
    font-size: 0.55rem;
}
.container_list img {
  width: 10vw;
}
.container_list .row{
    background-color: black;
    width: 100%;
    padding-top: 5px;
    padding-bottom: 2px;
    margin-bottom: 2vh;
    padding-right: 2px;
    border-radius: 12px;
}

h4{
  background-color: black;
  font-family: EATHOMASANS;
  font-size: 0.7rem;
  color: #ddc237;
  padding: 10px;
  border-radius: 5px;
  margin-top: 10px;
  margin-left: 10px;
}
.top_cart{
  height: 30vh;
  margin-top: 10vh;
  width: 100vw;
}
.row{
  margin: 0;
}
.negro{
  position: fixed;
  background-color: #ddc237;
  top: 0;
  width: 100vw;
  height: 8vh;
}
.store_topbar{
    font-family: EathomaSans;
    background-color: black;
    height: 5vh;
    color: #ddc237;
    margin-top: 3vh;
    justify-content: center;
    text-align: center;
}
.store_topbar img{
    width: 15vw;
    right: 4vw;
    position: fixed;
    top: 2vh;
}
/*HOLA*/


  .container {
    font-size: 0.9rem;
    max-width: 80rem;
  }

  .btn-group button {
    background-color: black;
    color: white;
  }

  .btn-dark {
    background-color: black;
    color: black;
  }
  #table_shopping{
    width: 50%;
  }
  .cart_buttons{
    background-color: rgb(245, 166, 35)!important;
    color: black!important;
  }
  
  @media only screen and (max-width: 1500px) {
    #table_shopping{
    width: 60%;
  }
  }
  @media only screen and (max-width: 1300px) {
    #table_shopping{
    width: 70%;
  }
  }
  @media only screen and (max-width: 1100px) {
    #table_shopping{
    width: 90%;
  }
  }
  @media only screen and (max-width: 850px) {
    #table_shopping{
    width: 98%;
  }
  }
</style>