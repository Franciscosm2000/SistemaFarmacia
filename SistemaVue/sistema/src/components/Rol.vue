<template>
    <v-layout align-start>
        <v-flex>
            <v-toolbar flat color="white">
                <v-toolbar-title>Roles</v-toolbar-title>
                    <v-divider
                    class="mx-2"
                    inset
                    vertical
                    ></v-divider>
                    <v-spacer></v-spacer>
                    <v-text-field class="text-xs-center" v-model="search" append-icon="search" label="Búsqueda" single-line hide-details></v-text-field>
                    <v-spacer></v-spacer>
            </v-toolbar>
            <v-data-table
                :headers="headers"
                :items="roles"
                :search="search"
                class="elevation-1"
            >
                <template slot="items" slot-scope="props">                    
                    <td>{{ props.item.nombre }}</td>
                    <td>{{ props.item.descripcion }}</td>
                    <td>
                        <div v-if="props.item.condicion">
                            <span class="blue--text">Activo</span>
                        </div>
                        <div v-else>
                            <span class="red--text">Inactivo</span>
                        </div>
                    </td>
                </template>
                <template slot="no-data">
                <v-btn color="primary" @click="listar">Resetear</v-btn>
                </template>
            </v-data-table>

            <!-- PANTALLA DE CARGA-->
            <PantallaCarga :activo="carga" @escucharResultPantalla="resultPantalla()"> </PantallaCarga>
             <!-- DIALOGO DE ERROR-->
           <Mensaje :activo="activarError" :msj="msjError" :tipo="tipoMsj" @escucharResultMsj="resultMsj()"> </Mensaje>
            <!--- CIERRE DE SECION --->
            <Secion :activo="login_" @escucharResult="resultHijo()" ></Secion>

        </v-flex>
    </v-layout>
</template>
<script>
    import axios from 'axios'
    import Secion from '@/components/Secion'
    import Mensaje from '@/components/Mensaje';
    import PantallaCarga from '@/components/PantallaCarga';
    export default {
        data(){
            return {
                roles:[],                
                dialog: false,
                headers: [
                    { text: 'Nombre', value: 'nombre' },
                    { text: 'Descripción', value: 'descripcion', sortable: false  },
                    { text: 'Estado', value: 'condicion' }                
                ],
                search: '',
                login_:false,
                tipoMsj:'',
                msjError:'',
                activarError:false,
                carga:false,             
            }
        },
        computed: {
        },

        watch: {
        },
        components:{
            Secion,
            Mensaje,
            PantallaCarga
        },

        created () {
            this.listar();
        },
        //SECION
            resultHijo(){
                this.login_ = false;
            },
            resultMsj(){
               this.activarError = false; 
            },  
            resultPantalla(){
                this.carga = false;
            },
            activarErrores(tipo,err,color){
                if(tipo == 1){
                    this.login_ =true;
                }else{
                    this.activarError=true;
                    this.msjError = err;
                    this.tipoMsj = color;
                    setTimeout(this.resultMsj,2000);
                }
            },
            //FIN - SECION
        methods:{
            listar(){
                this.carga = true;
                let me=this;
                let header={"Authorization" : "Bearer " + this.$store.state.token};
                let configuracion= {headers : header};
                axios.get('api/Roles/Listar',configuracion).then(function(response){
                    //console.log(response);
                    me.roles=response.data;
                    me.carga = false;
                }).catch(function(error){
                    me.carga =false; //Cierre de pantalla
                    if (error.response.status==401){
                        me.activarErrores(1);
                    }
                    else if (error.response.status == 403){
                        me.activarErrores(2,"Error de permisos.","orange"); 
                    }
                    else{
                        me.activarErrores(2,error.response.data,"red");
                    }
                });
            }
        }        
    }
</script>
