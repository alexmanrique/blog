---
title:  "Compilaciones lentas y despliegues rápidos"
date:   2017-07-20 20:13:53 +0200
categories: development
comments: true
lang: es
ref: builds
---

¿Qué pensarías si tus <a href="https://en.wikipedia.org/wiki/Software_developer">desarrolladores</a> tuvieran que esperar mucho tiempo antes de probar los cambios de código que acaban de codificar? Recuerdo hace 5 años un proyecto en que la <a href="https://en.wikipedia.org/wiki/Software_build">compilación</a> y el <a href="https://en.wikipedia.org/wiki/Software_deployment">despliegue</a> de la aplicación en la que estaba trabajando tardaban 13 minutos y 21 segundos.


Tiempo perdido
----------------------

Si multiplicas este tiempo por el número de compilaciones al día que un desarrollador puede hacer son 801 segundos * n compilaciones = 801 * n segundos = <b>0.2225n horas</b> por día. Si multiplicas 0.2225*n * 20 días * 12 meses = <b>53.4n horas</b> por año que son desperdiciadas debido a una compilación lenta lo que lleva a <b>6.675*n días improductivos</b> por desarrollador.

En la siguiente gráfica se puede ver la cantidad de días perdidos considerando la cantidad de compilaciones por día de un desarrollador.

![Number of days wasted]({{ site.baseurl }}/images/plot.png)

Si `n=15` el número de días perdidos por año són 100 (100/(20*12) -> <b>41%</b> días de trabajo por año)

En el siguiente enlace puedes ir a google para ver la gráfica <a href="https://www.google.es/search?q=plot+6.675x">Plot 6.675x</a>

No estamos considerando otros factores que hacen decaer la productividad de un desarrollador que durante este tiempo que está esperando empieza a hacer otras cosas perdiendo el <a href="https://www.youtube.com/watch?v=77RubAueWjg">foco</a> en aquello que estaba haciendo.  

Añade el precio por hora que le pagas a tus desarolladores y es bastante dinero.

{% highlight python %}

6.675 * n * num_devs_en_una_empresa * precio_hora_desarrollador = dinero = tiempo

{% endhighlight %}

Si la compilación pasa mucho tiempo posiblemente sea porque tienes que compilar un montón de código y si tienes un montón de código tal vez tengas una gran aplicación que debería dividirse en partes más pequeñas para reducir el tiempo de compilación y crear pequeños servicios. Lo que hoy se llaman <a href="https://martinfowler.com/articles/microservices.html">microservices.</a>


Ahorrando tiempo 
----------------

Todo lo que ahorra tiempo, es algo bueno. Es imposible reducir el tiempo de compilación a 0 segundos, pero hacer que la compilación y el despliegue sean rápidos debe ser algo a tener en cuenta mientras se trabaja en el desarrollo de software.

En mi equipo tengo que desarrollar software en diferentes módulos de software y tratamos de hacer que la compilación y el despliegue sea simple y rápido. Una de las cosas que hicimos fue crear un perfil <a href="https://en.wikipedia.org/wiki/Apache_Maven">maven</a> que cada vez que se realiza un `clean` `install` localmente, copia el `ear` automáticamente a la carpeta `deployment` de <a href="https://es.wikipedia.org/wiki/WildFly#Servidor_de_aplicaciones_JBoss">JBoss</a> utilizando la variable de entorno JBOSS_HOME y el `plugin` <a href="http://maven.apache.org/plugins/maven-antrun-plugin/">maven-antrun-plugin</a>

{% highlight xml %}

        <profile>
            <id>deploy-jboss-64</id>
            <build>
                <plugins>
                    <plugin>
                        <artifactId>maven-antrun-plugin</artifactId>
                        <executions>
                            <execution>
                                <id>deploy-DU</id>
                                <phase>install</phase>
                                <goals>
                                    <goal>run</goal>
                                </goals>
                                <configuration>
                                    <tasks>
                                        <copy overwrite="true" file="target/${project.artifactId}.ear"
                                              todir="${env.JBOSS_HOME}/standalone/deployments"/>
                                    </tasks>
                                </configuration>
                            </execution>
                        </executions>
                    </plugin>
                </plugins>
            </build>
        </profile>  

{% endhighlight %}

Esto me ahorra tiempo a mi (y para los otros desarrolladores que se desarrollan en el mismo módulo) cada vez que tenemos que desplegar una nueva versión de un archivo <a href="https://en.wikipedia.org/wiki/EAR_(file_format)">ear</a> en mi servidor de aplicaciones <a href="https://es.wikipedia.org/wiki/WildFly#Servidor_de_aplicaciones_JBoss">JBoss</a> local . De lo contrario, tendria que copiar manualmente el fichero `ear` resultante de la compilación en la carpeta de `deployment` de JBoss cada vez.

Conclusión 
----------------

Todo esto me lleva a pensar que, en una organización, es importante que todos, un equipo o al menos una persona se hagan conscientes de qué mejoras se pueden hacer para acelerar los procesos de construcción y despliegue. Todo este tiempo podría dedicarse a implementar nuevos productos o servicios que podrían aportar valor a su organización. Esto es lo que se llama el <a href="http://www.investopedia.com/terms/o/opportunitycost.asp">cost of opportunity</a> y se aplica a su vida laboral y también a su vida personal.


