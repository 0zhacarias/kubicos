<template>
    <PortalLayout>
        <template>
            <h1>Image Gallery</h1>
            <vue-images :images="images" @close="closeImage"></vue-images>
            <div class="image-thumbnails">
                <div v-for="(image, index) in images" :key="index" @click="openImage(index)">
                    <img :src="image.src" alt="Thumbnail">
                </div>
            </div>

        </template>
    </PortalLayout>
</template>
<script>
import PortalLayout from "../../Templates/PortalLayout.vue";
// import VueThumbnailer from 'vue-thumbnailer';
// import VueImages from 'vue-images';
// import image1 from '../../../img/Aaa.png';
// import image2 from '../assets/jason-briscoe.jpg';
// import image3 from '../assets/jason-briscoe.jpg';
export default {
    components: {
        // VueThumbnailer,
        PortalLayout,
        VueImages,
    },
    data() {
        return {
            images: [
            {
                src: image1, alt: 'Image1',
            },
            // {
            //     src: image2, alt: 'Image2',
            // },
            // {
            //     src: image3, alt: 'Image3',
            // },
            // {
            //     src: image1, alt: 'Image4',
            // },
        ],
            // thumbnail: null,
    
    };
},

methods: {
    closeImage() {
      // Handle image close event if needed
    },
    openImage(index) {
        this.$refs.images.open(index); // Open the image at the specified index
    },
},
};
</script>


<style scoped>
.image-thumbnails {
    display: flex;
}

.image-thumbnails img {
    width: 100px;
    height: 100px;
    margin: 10px;
    cursor: pointer;
}
</style>
