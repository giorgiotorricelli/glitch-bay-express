import express from 'express';
import { index, show } from '../controllers/categoriesController.js';
import validateParams from '../middlewares/validateParams.js';

const router = express.Router();

router.get('/', index);
router.get('/:id', validateParams, show);

export default router;