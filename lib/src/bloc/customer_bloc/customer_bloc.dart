import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_event.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_state.dart';
import 'package:salles_tools/src/models/customer_model.dart';
import 'package:salles_tools/src/services/customer_service.dart';
import 'package:salles_tools/src/views/components/log.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerService _customerService;
  CustomerBloc(this._customerService);

  @override
  // TODO: implement initialState
  CustomerState get initialState => CustomerInitial();

  @override
  Stream<CustomerState> mapEventToState(CustomerEvent event) async* {
    if (event is FetchCustomer) {
      yield CustomerLoading();

      try {
        CustomerModel value = await _customerService.customerDMS(event.value);

        if (value.data.isEmpty || value.data == null) {
          yield CustomerFailed();
        } else {
          yield CustomerSuccess(value);
        }

      } catch(error) {
        log.warning("Error : ${error.toString()}");
        CustomerError valError = await _customerService.customerDMS(event.value);
        CustomerError(valError);
      }
    }
  }
}