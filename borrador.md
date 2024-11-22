# Viajes interestelares (`borrador.md`)

Un sistema de viajes interestelares que documenta viajes interplanetarios, planetas, puertos espaciales, tripulación, pasajero, agencia espacial, etc. Esta base de datos es un ficción futurista donde una civilización interplanetaria quiere llevar un registro de los viajes que ocurren en su espacio espacial. Podríamos hacer un símil con el planeta tierra donde existen varias naciones y se lleva un registro de los vuelos que hay entre los distintos aeropuertos.

## 1. Puerto espacial
Un puerto espacial es una localización en un planeta donde aterrizan y despegan las naves espaciales. Es el lugar donde los pasajeros embarcan o desembarcan de las naves. Cada puerto espacial tiene su codigo (MAR-03). A su vez es queremos almacenar datos varios como la capacidad de naves, ubicación (está en la superficie del planeta o en órbita) etc. Un puerto espacial es origen y destino de un viaje espacial.

## 2. Cuerpo celeste
Es un cuerpo celeste (planetas, lunas, asteroides, ...). Se guardan datos como las características del planeta. Su relación es con puerto espacial ??.

    ## 2.a estrella
    ## 2.b planeta
    ## 2.c lunas
    ## 2.d asteroide

## 3. Viaje espacial
Un viaje espacial es realizado por una nave. Cada vuelo tiene asignado un comandante. Cada vuelo es gestionado por una agencia espacial. También guardariamos DATE de salida y DATE de llegada, siempre en hora local del planeta.

## 4. Nave
Una nave realiza varios vuelos espaciales. A su vez es propiedad de una agencia espacial (empresa??). Guardariamos atributos como nombre, fabricante, tipo de combustible, etc.

## 5. Agencia espacial
Una agencia espacial gestiona varios viajes espaciales. Una agencia espacial tiene en flota varias naves. También guardamos nombre, director (CEO), nacion origen ??, publico o privado, ...

## 6. Pasajero

## 7. Comandante

## ¿Qué faltaría?

    1. PERSONAS. Como gestionamos los tripulantes (trabajadores de una nave), viajeros, comandantes (tripulantes especiales), CEOs, etc. Deberiamos hacer una entidad persona y lo demás entidades hijos? A debatir
    2. NACIONES. Podríamos considerar una galaxia con varias naciones (símil: tierra-naciones; galaxia-estados). Así podriamos asignar un puerto espacial a una nación. 
    3. NAVES. Cuanto queremos complicar esta clase? Podemos poner atributos simples o hacer una ficha tecnica mas extensa (como si fuera un coche)

Quedo a la espera de vuestra respuesta para poder debatir el modelo :)

## Especializaciones (tipos de naves, comandantes y tripulacion, etc.)

## Categoria (Viajero, un tripulante y un pasajero pueden ir a la vez en un viaje)

## Subclase compartida 

