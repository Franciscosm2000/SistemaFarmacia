<template>
<v-layout>
    <v-dialog v-model="retornar"
        transition="dialog-bottom-transition"
        max-width="600"  persistent
    >
        <template >
        <v-card>
            <v-toolbar
            color="warning"
            dark
            >Sesión agotada </v-toolbar>
            <v-card-text style="display: flex;">
            <div> <v-icon style="font-size: 100px;  margin-top: 30px;">error_outline</v-icon> </div>    
            <div class="text-h6 pa-12" style="    font-size: 20px; margin-top: 40px; margin-left: 10px;"> El tiempo se ha agotado, favor iniciar sesión nuevamente.</div>
            </v-card-text>
            <v-card-actions class="justify-end">
            <v-btn @click="dialog=true"  flat color="green">
                Reanudar
            </v-btn>
            <v-btn
                flat
                @click="salir()"
            >Ok</v-btn>
            </v-card-actions>
        </v-card>
        </template>
    </v-dialog>

    <div id="dialogClave">
    <v-dialog 
        v-model="dialog" 
        max-width="290"
        >
        <v-card>
            <v-card-title class="headline">Ingrese sú contraseña</v-card-title>

            <v-card-text>
                <v-text-field @keyup.enter="reanudar()" autofocus v-model="password" :append-icon="show1 ? 'visibility' : 'visibility_off'" :type="show1 ? 'text' : 'password'"  @click:append="show1 = !show1" color="accent" label="Password" required>
                </v-text-field>
            </v-card-text>

            <v-card-actions>
            <v-spacer></v-spacer>

            <v-btn
                color="green darken-1"
                flat
                @click="reanudar()"
            >
                Ok
            </v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
    </div>

</v-layout>
    
</template>
<script>
    import axios from 'axios'
    export default {
        data(){
            return { 
                activo1:false,
                dialog:false,
                password:'',
                show1:false,
            }
        },
        props:{
            activo:null
        },
        computed:{
            retornar(){                
                this.activo1 = this.activo;
                
                return  this.activo1;
            },
        },
        methods:{
            enviarResult(){
                this.$emit('escucharResult',false);
            },
            salir(){
                this.$store.dispatch("salir");
            },
            reanudar(){
               this.dialog = false;
              // prompt('Clave del usuario '+ this.$store.state.usuario.usuario)
               var b= this.password;
                axios.post('api/Usuarios/Login', {usuario: this.$store.state.usuario.usuario, password: b})
                .then(respuesta => {
                    return respuesta.data
                })
                .then(data => {   
                    //eliminamos anterios
                     localStorage.removeItem("token")
                    //guardamos nueva secion 
                    this.enviarResult();
                    //this.retornar ();
                    this.$store.dispatch("guardarToken", data.token)
                    //this.listar();
                }) .catch(err => {
                     console.log(err.response);
                    if (err.response.status===400){
                        alert("No es un usuario válido");
                    } else if (err.response.status===404){
                       alert("No existe el usuario o sus datos son incorrectos");
                    }else{
                        alert("Ocurrió un error");
                        this.salir();
                    }
                    
                });
            
            },
        }        
    }
</script>
<style >
    .negritaLabel{
        font-size: 30px;
        font-weight: bold;
    }   
     .msjSesion{
    font-size: 20px;
    margin-top: 50px;
    margin-left: 5px;
    }
</style>