<template>
<div>
  <checkout-modal description="Yopo.pe" :transaction-amount="items.map(e => e.weight * e.sale_price).reduce((a, b) => a + b, 0) + (sale.delivery_price || 0)" :sale="sale" @confirm="successCheckout" @error="errorCheckout"/>
  <customer-modal @confirm="submit"/>
  <div class="row d-sm-block d-md-none" style="background-color: #ddc237; min-height:20vh">
    <nav class="navbar navbar-expand-md navbar-light shadow-sm fixed-top store_topbar">
      DETALLES DE SU COMPRA
      <router-link to="/shopping" class="d-flex align-items-center" style="color: black; font-size: 0.8rem; position:fixed; right:20vw">
        <img src="@/assets/img/black_circle.png" alt="">
      </router-link>   
      <a href="https://wa.me/51924649794" class="" >
        <i class="fas fa-arrow-circle-left" style="position: absolute;color: #ddc237;left: 3vw;top: 1px;font-size: 2rem;"></i>
      </a>   
    </nav>

    <div class="negro"></div>
    <div class="top_cart">
        <div class="row">
          <h4>Informacion Venta : &nbsp Y - 000{{(sale.id)}} </h4>
        </div>
        <div class="row container_list">
          <div class="row" v-for='item in products' :key="item.id">
            <div class="col-7">
              <img style="width: 10vw;" :src="`/api/products/${item.product.image_url}`" alt=""/>
               &nbsp &nbsp
               {{item.product.name}} &nbsp
              <div class="btn counter">
               {{ item.totalWeight }}
              </div>
            </div>
            <div class="col-5 row">
              <div class="col-6" style="text-align:right; padding-left: 1px;padding-right: 1px;">
                 S/ {{ item.sale_price.toFixed(2) }}
              </div>
              <div class="col-6" style="text-align:right; padding-left: 1px;padding-right: 1px;">
                <span >
                  S/ {{ (item.totalWeight * item.sale_price).toFixed(2) }}
                </span>
              </div>
            </div>            
          </div>
        </div>
    </div>
    </div>
    <div class="bot_cart">
      <div class="row">
        <h4>RESUMEN</h4>
      </div>
      <div class="row">
        <h4>CLIENTE: {{sale.customer.name}} </h4>
        <h4>DISTRITO: {{ sale.delivery.name }}</h4>
      </div>
      <div>        <h4>{{ sale.customer.address }}</h4> </div>
      <div class="row">
        <h4>SUBTOTAL: S/ {{ (items.map(e => e.weight * e.sale_price).reduce((a, b) => a + b, 0) + 0).toFixed(2) }}</h4>
        <h4>COSTO DE ENVIO: S/ {{ sale.delivery_price }}</h4>

      </div>
      <div class="row sale_info">
          <div class="row">
            <div class="col-6" style="text-align:left">TOTAL</div>
            <div class="col-6" style="text-align:right">S/ {{ (items.map(e => e.weight * e.sale_price).reduce((a, b) => a + b, 0) + sale.delivery_price).toFixed(2) }} </div>
          </div>
      </div>
      <hr>
      <div class="row" style="justify-content:center">
        <h4>ACEPTAMOS TODOS LOS MEDIO DE PAGO</h4>
      </div>
      <div class="row" style="text-align: center;">
        <div class="col-4" style="padding: 10px;">
          <img src="https://suministrosperu.com/wp-content/uploads/2016/01/YAPE-QR.png" alt="" style="width:90%">
        </div>
        <div class="col-4" style="padding: 10px;">
          <img src="https://suministrosperu.com/wp-content/uploads/2016/01/YAPE-QR.png" alt="" style="width:90%">
        </div>
        <div class="col-4" style="align-items:center; display:flex">
          <img src="https://seeds.promo/wp-content/uploads/2019/08/Visa-MasterCard-1024x393.png" alt="" style="width:100%">
        </div>
      </div>
      <div class="row" style="text-align: center;">
        <div class="col-4" style="padding: 10px; font-family: 'EATHOMASANS'; font-size: 0.75rem;">
          YAPE <br>
          924649794
        </div>
        <div class="col-4" style="padding: 10px; font-family: 'EATHOMASANS'; font-size: 0.75rem;">
          PLIN <br>
          924649794
        </div>
        <div class="col-4" style="align-items:center; display:flex;">
          <button type="button" class="btn" data-toggle="modal" data-target="#checkoutModal" v-if="!sale.payment_id" style="font-family: 'EATHOMASANS'; font-size: 0.65rem; border: 1px solid black; border-radius:5px">
            Tarjeta Credito/Debito
          </button>
        </div>
      </div>
        <img src="@/assets/img/left_esquina.png" alt="" id="left_esquina">
        <img src="@/assets/img/right_esquina.png" alt="" id="right_esquina">
    </div>
</div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import CustomerModal from '@/components/CustomerModal'
import CheckoutModal from '@/components/CheckoutPaymentModal'

export default {
  components: {
    CustomerModal,
    CheckoutModal,
  },
  mounted() {
    this.loadMercadoPago();
    var saleId = this.$route.params.saleId;
    if (saleId) {
      axios.get(`sales/${saleId}`).then(res => {
        console.log(res);
        var sale = res.data.sale;
        this.setSale(sale);
        this.items = sale.items;
        let groupItems = res.data.items;
        for (const key in groupItems) {
          if (groupItems.hasOwnProperty(key)) {
            const element = groupItems[key];
            let product = element[0];
            product.totalWeight = element.map(e => e.weight).reduce((a, b) => a + b, 0);
            this.products.push(product);
          }
        }
      });
    } else {
      if (!this.sale.customer_id) {
        this.$router.replace(`/shopping`);
      }
    }
  },
  data() {
    return {
      token: process.env.VUE_APP_TOKEN || 'TEST-dd114825-b697-4ce1-9f03-e5fce322b40f',
      inventories: [],
      checkout: {},
      years : [        
        2021,
        2022,
        2023,
        2024,
        2025,
        2026
      ],
      months: [
        '01',
        '02',
        '03',
        '04',
        '05',
        '06',
        '07',
        '08',
        '09',
        '10',
        '11',
        '12',
      ],
      products: [],
      items: [],
      groupitems: [],
    }
  },
  computed: {
    ...mapGetters({
      sale: 'sale/getSale',
      totalProducts: 'sale/totalProducts',
      // products: 'sale/products',
    }),
  },
  methods: {
    ...mapActions({
      addProduct: 'sale/addProduct',
      removeAllProducts: 'sale/removeAllProducts',
      setSale: 'sale/setSale',
    }),
    successCheckout(data) {
      // this.$router.replace(`/${data.sale.id}/checkoutDetails`);
      // axios.get('shoppings/removeAll').catch(err => {
      //   console.log(err.response);
      // });
      // this.removeAllProducts();
      // console.log(data);
      // location.reload();
    },
    errorCheckout(error) {
      console.log(data);
    },
    submit(sale) {
      this.setSale(sale);
      $('.modal').modal('hide');
      $('#checkoutModal').modal('show');
      this.$loading(false);
    },
    loadMercadoPago() {
      Mercadopago.getIdentificationTypes();
      Mercadopago.setPublishableKey(this.token);
    },
    guessPaymentMethod() {
      let cardnumber = document.getElementById("cardNumber").value;
      if (cardnumber.length >= 6) {
      let bin = cardnumber.substring(0,6);
      Mercadopago.getPaymentMethod({
        "bin": bin
      }, this.setPaymentMethod.bind(this));
      }
    },
    setPaymentMethod(status, response) {
      if (status == 200) {
        let paymentMethodId = response[0].id;
        let element = document.getElementById('payment_method_id');
        element.value = paymentMethodId;
      } else {
        alert(`payment method info error: ${response}`);
      }
    }, 
    getInstallments() {
      Mercadopago.getInstallments({
        "payment_method_id" : document.getElementById('payment_method_id').value,
        "amount": parseFloat(document.getElementById('transaction_amount').value)
      }, function (status, response) {
      if (status == 200) {
        document.getElementById('installments').options.length = 0;
        response[0].payer_costs.forEach(installment => {
          let opt = document.createElement('option');
          opt.text = installment.recommended_message;
          opt.value = installment.installments;
          document.getElementById('installments').appendChild(opt);
        });
      } else {
        alert(`installments method info error: ${response}`);
      }
      });
    },
    sdkResponseHandler(status, response) {
      console.log(status)
      console.log(response)
      if (status != 200 && status != 201) {
        let msg = "";
        for (let data in response.cause) {
          msg += response.cause[data].code + "-" + response.cause[data].description;
        }
        alert(msg);
      } else {
        document.getElementById("token").value = response.id;
        var inventories = [];
        this.products.forEach(item => {
          inventories.push(...this.checkInventory(item));
        });
        if (inventories.length) {
          var sale = this.sale;
          sale.channel = 'TIENDA VIRTUAL';
          sale.deliver_date = 'true';
          axios.post('sales', { inventories, sale }).then(res => {
            console.log(res);
            axios.get('shoppings/removeAll').catch(err => {
              console.log(err.response);
            });
            let sale = res.data.sale;
            this.removeAllProducts();
            axios.post('checkout', {
              'payment_method_id': document.getElementById('payment_method_id').value,
              'transaction_amount': document.getElementById('transaction_amount').value,
              'token': document.getElementById("token").value,
              'email': document.getElementById('email').value,
              sale,
            }).then(res => {
              this.$loading(false);
              console.log(res.data);
              this.$router.replace(`/${sale.id}/checkout`);
              location.reload();
              this.$snotify.success('Compra reazalizada correctamente');
            }).catch(err => {
              this.$loading(false);
              console.log(err);
              var res = err.response;
              console.log(err.response);
              if (res.data.msg[2]) {
                alert(res.data.msg[0]);
              } else {
                alert(res.data.msg[0]);
                window.location.reload(0)
              }
            });
          }).catch(err => {
            console.log(err.response);
          });
        } else {
          this.$snotify.error('Debe haber almenos un producto disponible');
          $('.modal').modal('hide');
        }
      }
    }
  }
}
</script>

<style scoped>
  .container {
    max-width: 70rem;
  }
  form {
    /* color: white; */
    font-size: 1.5rem;
  }
  .cart_buttons{
    background-color: rgb(245, 166, 35)!important;
    color: black!important;
  }

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
  width: 100vw;
  padding-bottom: 10vh;
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
    padding-top: 7px;
    padding-bottom: 2px;
    margin-bottom: 2vh;
    padding-right: 5px;
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
  margin-top: 10vh;
  width: 100vw;
}
.row{
  margin: 0;
}
.negro{
  z-index: 2;
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
    font-size: 0.9rem;
}
.store_topbar img{
    width: 15vw;
    right: 4vw;
    position: fixed;
    top: 2vh;
}
</style>